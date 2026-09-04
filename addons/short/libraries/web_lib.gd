## @experimental: This class could change.
## Work with the web.
##
## Available in all scripts without any setup.

@abstract class_name WebLib extends Object


#region methods
## Downloads data from the web [param url] and stores it at [param save_path]. See also [HTTPRequest].
static func download(url: String, save_path: String) -> DownloadResult:
	var result: DownloadResult = DownloadResult.new()
	
	var https: HTTPRequest = HTTPRequest.new()
	var tree: SceneTree = Engine.get_main_loop()
	tree.root.add_child(https)
	https.download_file = save_path
	https.use_threads = true
	
	result.error = https.request(url)
	var request_completed_result: Array = await https.request_completed
	
	result.result = request_completed_result[0]
	result.response_code = request_completed_result[1]
	result.data = request_completed_result[3]
	
	https.queue_free()
	
	return result
#endregion methods


#region classes
## The result returned by [method WebLib.download].
class DownloadResult:
	## The [Error] returned by [method HTTPRequest.request].
	var error: Error
	## The [enum HTTPRequest.Result].
	var result: HTTPRequest.Result
	## The [signal HTTPRequest.request_completed] response code.
	var response_code: int
	## The downloaded data.
	var data: PackedByteArray
#endregion classes
