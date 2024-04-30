
data "tfe_outputs" "outputs" {
  organization = "ddi-support"
  workspace = "test_tfe_outputs"
}

locals {
  tfe_outputs = merge(
     #make sure variables key and this key are same!!!
    {
      app1 = {
        service_plan_id     = data.test_tfe_outputs.outputs.values.appid
      }
    },
  )
}

locals {
  merged_appservice_windows = {
    for key, value in var.appservice_windows : key =>  merge(var.appservice_windows[key], local.tfe_outputs[key])
  }
}


#module "app_m" {
 #   source = "./config_app"
  #  appservice_windows = local.merged_appservice_windows
#}

module "appservice" {
  source  = "app.terraform.io/ddi-support/appservice/azurerm"
  version = "1.0.0"
  appservice_windows = local.merged_appservice_windows
}
