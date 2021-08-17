resource "aws_secretsmanager_secret" "new_secret_object" {

  name                     = var.secret_name
  description              = "RDS info"
  kms_key_id               = var.secret_cmk_id
  recovery_window_in_days  = 0

  lifecycle {
    ignore_changes = [
      tags["Date"],
    ]
  }
  
  tags = {
    Author = "Effectual Terraform script"
    Date = "${timestamp()}"
  } 

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "secret-policy",
    "Statement": [
        {
            "Sid": "AllowUseOfTheKey",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${var.cicd_role_arn}"
            },
            "Action": [
                "secretsmanager:GetSecretValue"
            ],
            "Resource": "*",
            "Condition": { "ForAnyValue:StringLike": { "secretsmanager:SecretId": "*${var.secret_name}*" } }
        }
    ]
}
EOF
}

resource "aws_secretsmanager_secret_version" "values" {

  secret_id     = aws_secretsmanager_secret.new_secret_object.id

  lifecycle {
    ignore_changes = [
      secret_id,
      secret_string,
    ]
  }

   secret_string = <<EOF
    {
      "DBName"     : "${var.secret_value_dbname}",
      "DBEndPoint" : "${var.secret_value_dbendpoint}",
      "DBARN"      : "${var.secret_value_dbarn}",
      "Username"   : "${var.secret_value_dbusername}",
      "Password"   : "${var.secret_value_dbpassword}", 
      "Port"       : "${var.db_port}",
      "Account"    : "${var.account_name}",
      "Engine"     : "${var.engine_name}"
    }
EOF
}
