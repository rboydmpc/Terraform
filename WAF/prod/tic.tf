resource "aws_wafv2_regex_pattern_set" "Authorization_Basic" {
  name        = "Authorization_Basic"
  description = "Authorization_Basic"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = ".*basic.*"
  }
}

resource "aws_wafv2_regex_pattern_set" "Authorization_Digest" {
  name        = "Authorization_Digest"
  description = "Authorization_Digest"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = ".*digest.*"
  }
}

resource "aws_wafv2_regex_pattern_set" "Authorization_Bearer" {
  name        = "Authorization_Bearer"
  description = "Authorization_Bearer"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = ".*bearer.*"
  }
}

resource "aws_wafv2_regex_pattern_set" "Authorization_Negotiate" {
  name        = "Authorization_Negotiate"
  description = "Authorization_Negotiate"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = ".*negotiate.*"
  }
}

resource "aws_wafv2_regex_pattern_set" "Authorization_NTLM" {
  name        = "Authorization_NTLM"
  description = "Authorization_NTLM"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = ".*ntlm.*"
  }
}

resource "aws_wafv2_regex_pattern_set" "Content_Json" {
  name        = "Content_Json"
  description = "Content_Json"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "application.json"
  }
}

resource "aws_wafv2_regex_pattern_set" "Content_Xml" {
  name        = "Content_Xml"
  description = "Content_Xml"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "application.xml"
  }
}

resource "aws_wafv2_regex_pattern_set" "Content_Xhtml" {
  name        = "Content_Xhtml"
  description = "Content_Xhtml"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "application.xhtml.xml"
  }
}

resource "aws_wafv2_regex_pattern_set" "Content_Form_Encoded" {
  name        = "Content_Form_Encoded"
  description = "Content_Form_Encoded"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "application.x.www.form.urlencoded"
  }
}

resource "aws_wafv2_regex_pattern_set" "Content_Html" {
  name        = "Content_Html"
  description = "Content_Html"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "text.html"
  }
}

resource "aws_wafv2_regex_pattern_set" "Content_Form_Data" {
  name        = "Content_Form_Data"
  description = "Content_Form_Data"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "multipart.form.data"
  }
}

resource "aws_wafv2_regex_pattern_set" "Content_Text" {
  name        = "Content_Text"
  description = "Content_Text"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "text.plain"
  }
}

resource "aws_wafv2_regex_pattern_set" "User_Agent_iPhone" {
  name        = "User_Agent_iPhone"
  description = "User_Agent_iPhone"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = ".*iphone.*"
  }
}

resource "aws_wafv2_regex_pattern_set" "User_Agent_Android" {
  name        = "User_Agent_Android"
  description = "User_Agent_Android"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = ".*android.*"
  }
}

resource "aws_wafv2_regex_pattern_set" "User_Agent_Windows" {
  name        = "User_Agent_Windows"
  description = "User_Agent_Windows"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = ".*windows.*"
  }
}

resource "aws_wafv2_regex_pattern_set" "User_Agent_Linux" {
  name        = "User_Agent_Linux"
  description = "User_Agent_Linux"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = ".*linux.*"
  }
}

resource "aws_wafv2_regex_pattern_set" "User_Agent_Macintosh" {
  name        = "User_Agent_Macintosh"
  description = "User_Agent_Macintosh"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = ".*macintosh.*"
  }
}

resource "aws_wafv2_regex_pattern_set" "HTTP_GET" {
  name        = "HTTP_GET"
  description = "HTTP_GET"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "get"
  }
}

resource "aws_wafv2_regex_pattern_set" "HTTP_POST" {
  name        = "HTTP_POST"
  description = "HTTP_POST"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "post"
  }
}

resource "aws_wafv2_regex_pattern_set" "HTTP_PUT" {
  name        = "HTTP_PUT"
  description = "HTTP_PUT"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "put"
  }
}

resource "aws_wafv2_regex_pattern_set" "HTTP_DELETE" {
  name        = "HTTP_DELETE"
  description = "HTTP_DELETE"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = "delete"
  }
}

resource "aws_wafv2_regex_pattern_set" "Host_Ciphercloud" {
  name        = "Host_Ciphercloud"
  description = "Host_Ciphercloud"
  scope       = "REGIONAL"

  regular_expression {
    regex_string = ".*cc.ginniemae.gov"
  }
}

resource "aws_wafv2_ip_set" "Salesforce" {
  name               = "Salesforce"
  description        = "Salesforce IPs for CipherCloud Access"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = ["96.43.152.0/24", "96.43.153.0/24", "52.61.128.0/22", "52.61.132.0/22"]
}

resource "aws_wafv2_web_acl" "prod_waf_acl" {
  name        = "Prod_WAF_ACL"
  description = "AWS Managed Rules in WAF for Production External URLs"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "rule-1"
    priority = 1

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_AWS-AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-2"
    priority = 2

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_AWS-AWSManagedRulesAmazonIpReputationList"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-3"
    priority = 3

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_AWS-AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-4"
    priority = 4

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_AWS-AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-5"
    priority = 5

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAdminProtectionRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_AWS-AWSManagedRulesAdminProtectionRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-6"
    priority = 6

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_Basic.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_Basic_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-7"
    priority = 7

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_Basic.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_Basic_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-8"
    priority = 8

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_Basic.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_Basic_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-9"
    priority = 9

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_Digest.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_Digest_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-10"
    priority = 10

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_Digest.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_Digest_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-11"
    priority = 11

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_Digest.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_Digest_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-12"
    priority = 12

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_Bearer.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_Bearer_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-13"
    priority = 13

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_Bearer.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_Bearer_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-14"
    priority = 14

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_Bearer.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_Bearer_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-15"
    priority = 15

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_Negotiate.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_Negotiate_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-16"
    priority = 16

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_Negotiate.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_Negotiate_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-17"
    priority = 17

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_Negotiate.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_Negotiate_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-18"
    priority = 18

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_NTLM.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_NTLM_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-19"
    priority = 19

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_NTLM.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_NTLM_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-20"
    priority = 20

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Authorization_NTLM.arn
            field_to_match {
              single_header {
                name = "authorization"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Authorization_NTLM_International"
      sampled_requests_enabled   = true
    }
  }

rule {
    name     = "rule-21"
    priority = 21

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Json.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Json_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-22"
    priority = 22

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Json.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Json_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-23"
    priority = 23

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Json.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Json_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-24"
    priority = 24

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Xml.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Xml_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-25"
    priority = 25

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Xml.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Xml_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-26"
    priority = 26

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Xml.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Xml_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-27"
    priority = 27

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Xhtml.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Xhtml_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-28"
    priority = 28

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Xhtml.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Xhtml_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-29"
    priority = 29

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Xhtml.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Xhtml_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-30"
    priority = 30

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Form_Encoded.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Form_Encoded_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-31"
    priority = 31

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Form_Encoded.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Form_Encoded_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-32"
    priority = 32

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Form_Encoded.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Form_Encoded_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-33"
    priority = 33

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Html.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Html_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-34"
    priority = 34

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Html.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Html_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-35"
    priority = 35

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Html.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Html_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-36"
    priority = 36

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Form_Data.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Form_Data_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-37"
    priority = 37

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Form_Data.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Form_Data_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-38"
    priority = 38

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Form_Data.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Form_Data_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-39"
    priority = 39

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Text.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Text_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-40"
    priority = 40

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Text.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Text_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-41"
    priority = 41

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Content_Text.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Content_Text_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-42"
    priority = 42

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_iPhone.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_iPhone_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-43"
    priority = 43

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_iPhone.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_iPhone_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-44"
    priority = 44

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_iPhone.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_iPhone_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-45"
    priority = 45

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_Android.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_Android_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-46"
    priority = 46

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_Android.arn
            field_to_match {
              single_header {
                name = "content-type"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_Android_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-47"
    priority = 47

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_Android.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_Android_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-48"
    priority = 48

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_Windows.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_Windows_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-49"
    priority = 49

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_Windows.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_Windows_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-50"
    priority = 50

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_Windows.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_Windows_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-51"
    priority = 51

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_Linux.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_Linux_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-52"
    priority = 52

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_Linux.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_Linux_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-53"
    priority = 53

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_Linux.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_Linux_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-54"
    priority = 54

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_Macintosh.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_Macintosh_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-55"
    priority = 55

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_Macintosh.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_Macintosh_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-56"
    priority = 56

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.User_Agent_Macintosh.arn
            field_to_match {
              single_header {
                name = "user-agent"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_User_Agent_Macintosh_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-57"
    priority = 57

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn            = aws_wafv2_regex_pattern_set.HTTP_GET.arn
            field_to_match {
              method {}
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_HTTP_GET_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-58"
    priority = 58

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.HTTP_GET.arn
            field_to_match {
              method {}
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_HTTP_GET_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-59"
    priority = 59

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.HTTP_GET.arn
            field_to_match {
              method {}
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_HTTP_GET_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-60"
    priority = 60

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.HTTP_PUT.arn
            field_to_match {
              method {}
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_HTTP_PUT_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-61"
    priority = 61

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.HTTP_PUT.arn
            field_to_match {
              method {}
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_HTTP_PUT_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-62"
    priority = 62

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.HTTP_PUT.arn
            field_to_match {
              method {}
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_HTTP_PUT_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-63"
    priority = 63

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.HTTP_POST.arn
            field_to_match {
              method {}
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_HTTP_POST_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-64"
    priority = 64

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.HTTP_POST.arn
            field_to_match {
              method {}
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_HTTP_POST_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-65"
    priority = 65

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.HTTP_POST.arn
            field_to_match {
              method {}
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_HTTP_POST_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-66"
    priority = 66

    action {
      count {}
    }

    statement {
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.HTTP_DELETE.arn
            field_to_match {
              method {}
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["US"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_HTTP_DELETE_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-67"
    priority = 67

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.HTTP_DELETE.arn
            field_to_match {
              method {}
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          geo_match_statement {
            country_codes = ["RU", "IR", "CN", "KP"]
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_HTTP_DELETE_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-68"
    priority = 68

    action {
      count {}
    }

    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.HTTP_DELETE.arn
            field_to_match {
              method {}
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              geo_match_statement {
                country_codes = ["US", "RU", "IR", "CN", "KP"]
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_HTTP_DELETE_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-69"
    priority = 69

    action {
      count {}
    }

    statement {
      geo_match_statement {
        country_codes = ["US"]
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_ANY_US"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-70"
    priority = 70

    action {
      count {}
    }
        
    statement {
      geo_match_statement {
        country_codes = ["RU", "IR", "CN", "KP"]
      }
    }
    
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_ANY_High_Risk"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-71"
    priority = 71

    action {
      count {}
    }
    
    statement {
      not_statement {
        statement {
          geo_match_statement {
            country_codes = ["US", "RU", "IR", "CN", "KP"]
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_ANY_International"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "rule-72"
    priority = 72

    action {
      block {}
    }
    
    statement{
      and_statement {
        statement {
          regex_pattern_set_reference_statement {
            arn = aws_wafv2_regex_pattern_set.Host_Ciphercloud.arn
            field_to_match {
              single_header {
                name = "host"
              }
            }
            text_transformation {
              priority = 1 
              type     = "LOWERCASE"
            }
          }
        }
        statement {
          not_statement {
            statement {
              ip_set_reference_statement {
                arn = aws_wafv2_ip_set.Salesforce.arn
              }
            }
          }
        }
      }  
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_Host_Ciphercloud_IP_Salesforce"
      sampled_requests_enabled   = true
    }
  }


  visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Prod_WAF_ACL"
      sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_web_acl_association" "prod_web_acl_association" {
  resource_arn = local.prod_external_alb
  web_acl_arn  = aws_wafv2_web_acl.prod_waf_acl.arn
}