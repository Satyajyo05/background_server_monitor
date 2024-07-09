//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <camera_windows/camera_windows.h>
#include <connectivity_plus/connectivity_plus_windows_plugin.h>
#include <flutter_document_scan_sdk/flutter_document_scan_sdk_plugin_c_api.h>
#include <flutter_ocr_sdk/flutter_ocr_sdk_plugin_c_api.h>
#include <permission_handler_windows/permission_handler_windows_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  CameraWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("CameraWindows"));
  ConnectivityPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ConnectivityPlusWindowsPlugin"));
  FlutterDocumentScanSdkPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterDocumentScanSdkPluginCApi"));
  FlutterOcrSdkPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterOcrSdkPluginCApi"));
  PermissionHandlerWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PermissionHandlerWindowsPlugin"));
}
