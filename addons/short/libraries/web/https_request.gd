## A more safe and abstract [HTTPRequest].

class_name HTTPSRequest extends HTTPRequest


#region methods
## Ensures that requested [param url] will be safe.
func safe_request(url: String, custom_headers: PackedStringArray = PackedStringArray(), method: HTTPClient.Method = HTTPClient.METHOD_GET, request_data: String = "") -> Error:
	assert(url.contains("https"), "Request must be safe.")
	return request(url, custom_headers, method, request_data)
#endregion methods
