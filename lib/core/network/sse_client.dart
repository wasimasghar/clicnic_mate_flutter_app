// Reads server-sent events from a streamed ClinicMate chat response.
// Event names and JSON data are joined at each blank line boundary.

import 'dart:async';
import 'dart:convert';
import '../../data/models/chat_stream_event.dart';
import 'api_client.dart';

/// Posts chat messages and yields decoded server-sent events.
class SseClient {
  const SseClient(this._apiClient);
  final ApiClient _apiClient;

  Stream<ChatStreamEvent> post(String path, Map<String, dynamic> body) async* {
    final response = await _apiClient.postStream(path, data: body);
    final stream = response.data?.stream;
    if (stream == null) return;
    var eventName = 'message';
    final dataLines = <String>[];
    // Dio exposes Uint8List chunks; cast each chunk to its List<int> interface
    // before applying Utf8Decoder, which accepts Stream<List<int>>.
    await for (final line
        in stream
            .cast<List<int>>()
            .transform(utf8.decoder)
            .transform(const LineSplitter())) {
      if (line.isEmpty) {
        if (dataLines.isNotEmpty) {
          final decoded = jsonDecode(dataLines.join('\n'));
          if (decoded is Map) {
            yield ChatStreamEvent(
              name: eventName,
              data: Map<String, dynamic>.from(decoded),
            );
          }
        }
        eventName = 'message';
        dataLines.clear();
      } else if (line.startsWith('event:')) {
        eventName = line.substring(6).trim();
      } else if (line.startsWith('data:')) {
        dataLines.add(line.substring(5).trimLeft());
      }
    }
    if (dataLines.isNotEmpty) {
      final decoded = jsonDecode(dataLines.join('\n'));
      if (decoded is Map) {
        yield ChatStreamEvent(
          name: eventName,
          data: Map<String, dynamic>.from(decoded),
        );
      }
    }
  }
}
