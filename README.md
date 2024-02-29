# terraform_test

Terraform testを実行するサンプルコード

## 動作確認済みバージョン
- Terraform
  - v1.7.0以降

## 前準備
[terraform](./terraform)ディレクトリ内の[terraform.tfvars](./terraform/terraform.tfvars)を自身のAzureの設定に適切に書き換える

## 実行手順
### moduleのテスト
1. 各[module](./terraform/modules/)ディレクトリ内で`terraform init`を実行する
    ```
    terraform init
    ```
2. `terraform test`を実行する
    ```
    terraform test
    ```
### 全体のテスト
1. terraformディレクトリ内で`terraform init`を実行する
    ```
    terraform init -test-directory=./test
    ```
2. `terraform test`を実行する
    ```
    terraform test -test-directory=./test
    ```

## 備考
稀に以下のようなエラーが発生する。<br>
```
Terraform encountered an error destroying resources created while executing test/main.tftest.hcl/deploy.
╷
│ Error: waiting for update of Network Interface: (Name "nic-test" / Resource Group "Sandbox-RD"): Code="InternalServerError" Message="An error occurred." Details=[]
│
│
╵

Terraform left the following resources in state after executing test/main.tftest.hcl/deploy, and they need to be cleaned up manually:
  - module.network.azurerm_subnet.subnet
  - module.network.azurerm_virtual_network.vnet
  - module.vm.azurerm_network_interface.network_interface
  - module.vm.azurerm_network_interface_security_group_association.nic_nsg
  - module.vm.azurerm_network_security_group.nsg
  - module.vm.azurerm_public_ip.ip
Terraform encountered an error destroying resources created while executing test/main.tftest.hcl/request.
```
`terraform test`では`terraform.state`をメモリ内に持つため一度エラーが発生するとterraformで削除することができない。<br>
この場合、該当するリソースをAzure portal上またはcliを用いて削除する必要がある。
