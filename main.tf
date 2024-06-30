
#create IAM USER
resource "aws_iam_user" "U_ahmed" {
  name = "Ahmed"
}


#Define the IAM Policy
resource "aws_iam_policy" "full_access_policy" {

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

#attachment_policy
resource "aws_iam_user_policy_attachment" "attach_ec2_policy" {
  user       = aws_iam_user.U_ahmed.id
  policy_arn = aws_iam_policy.full_access_policy.id
}




#create IAM USER
resource "aws_iam_user" "U_mahmoud" {
  name = "Mahmoud"
}

#Define the IAM Policy
resource "aws_iam_policy" "s3_policy" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
        ],
        Resource = "arn:aws:s3:::eraki-terrafrom-dev01/*",
        Condition = {
          IpAddress = {
            "aws:SourceIp" : ["10.0.0.0/24"]
          }
        }
      },
    ]
  })
}

#attachment_policy
resource "aws_iam_user_policy_attachment" "attach_s3_policy" {
  user       = aws_iam_user.U_mahmoud.id
  policy_arn = aws_iam_policy.s3_policy.id
}
 
#create IAM USER

resource "aws_iam_user" "U_mostafa" {
  name = "Mostafa"
  tags = {
    "Role" = aws_iam_role.s3_access_role.id
  }
}


#Define the IAM Role
resource "aws_iam_role" "s3_access_role" {
  name = "S3AccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::188480741:/mfathy"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

#Define the IAM Policy
resource "aws_iam_policy" "s3_access_policy" {
  name = "S3AccessPolicy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject", ],
        Resource = ["arn:aws:s3:::eraki-terrafrom-dev01/*"]
      }
    ]
  })
}

# Attach the Policy to the Role
resource "aws_iam_role_policy_attachment" "s3_access_role_attachment" {
  role       = aws_iam_role.s3_access_role.id
  policy_arn = aws_iam_policy.s3_access_policy.id
}


































































