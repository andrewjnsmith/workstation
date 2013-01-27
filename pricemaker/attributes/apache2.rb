node.default["apache2_settings"] = {
	"run_user" => WS_USER,
	"run_group" => "staff",
	"server_name" => "localhost",
	"document_root" => ::File.expand_path(::File.join("workspace", "default"), WS_HOME),
	"server_admin" => "systems@pricemaker.co.nz"
}