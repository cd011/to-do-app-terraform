# Security group
resource "aws_security_group" "main" {
  name   = "my-tf-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "ec2-instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  #   version = "5.8.0"

  name = "single-instance"

  ami                         = "ami-0731becbf832f281e"
  instance_type               = "t2.micro"
  key_name                    = "test-keypair"
  monitoring                  = false
  vpc_security_group_ids      = [aws_security_group.main.id]
  subnet_id                   = aws_subnet.subnets["my-tf-pub-sn-1"].id
  associate_public_ip_address = true
  user_data_base64            = "IyEvYmluL2Jhc2gKIyBVcGRhdGUgcGFja2FnZSBsaXN0IGFuZCBpbnN0YWxsIHByZXJlcXVpc2l0ZXMKYXB0LWdldCB1cGRhdGUgLXkKYXB0LWdldCBpbnN0YWxsIC15IFwKICAgIGNhLWNlcnRpZmljYXRlcyBcCiAgICBjdXJsIFwKICAgIGdudXBnIFwKICAgIGxzYi1yZWxlYXNlCgojIEFkZCBEb2NrZXLigJlzIG9mZmljaWFsIEdQRyBrZXkKaW5zdGFsbCAtbSAwNzU1IC1kIC9ldGMvYXB0L2tleXJpbmdzCmN1cmwgLWZzU0wgaHR0cHM6Ly9kb3dubG9hZC5kb2NrZXIuY29tL2xpbnV4L3VidW50dS9ncGcgfCBcCiAgICBncGcgLS1kZWFybW9yIC1vIC9ldGMvYXB0L2tleXJpbmdzL2RvY2tlci5ncGcKY2htb2QgYStyIC9ldGMvYXB0L2tleXJpbmdzL2RvY2tlci5ncGcKCiMgU2V0IHVwIHRoZSBEb2NrZXIgcmVwb3NpdG9yeQplY2hvIFwKICAiZGViIFthcmNoPSQoZHBrZyAtLXByaW50LWFyY2hpdGVjdHVyZSkgXAogIHNpZ25lZC1ieT0vZXRjL2FwdC9rZXlyaW5ncy9kb2NrZXIuZ3BnXSBcCiAgaHR0cHM6Ly9kb3dubG9hZC5kb2NrZXIuY29tL2xpbnV4L3VidW50dSBcCiAgJChsc2JfcmVsZWFzZSAtY3MpIHN0YWJsZSIgfCBcCiAgdGVlIC9ldGMvYXB0L3NvdXJjZXMubGlzdC5kL2RvY2tlci5saXN0ID4gL2Rldi9udWxsCgojIEluc3RhbGwgRG9ja2VyIEVuZ2luZQphcHQtZ2V0IHVwZGF0ZSAteQphcHQtZ2V0IGluc3RhbGwgLXkgZG9ja2VyLWNlIGRvY2tlci1jZS1jbGkgY29udGFpbmVyZC5pbyBkb2NrZXItYnVpbGR4LXBsdWdpbiBkb2NrZXItY29tcG9zZS1wbHVnaW4KCiMgRW5hYmxlIGFuZCBzdGFydCBEb2NrZXIKc3lzdGVtY3RsIGVuYWJsZSBkb2NrZXIKc3lzdGVtY3RsIHN0YXJ0IGRvY2tlcgoKIyBJbnN0YWxsIERvY2tlciBDb21wb3NlIChzdGFuZGFsb25lIHZlcnNpb24gaWYgbmVlZGVkKQpET0NLRVJfQ09NUE9TRV9WRVJTSU9OPSJ2Mi4yNy4xIgpjdXJsIC1MICJodHRwczovL2dpdGh1Yi5jb20vZG9ja2VyL2NvbXBvc2UvcmVsZWFzZXMvZG93bmxvYWQvJHtET0NLRVJfQ09NUE9TRV9WRVJTSU9OfS9kb2NrZXItY29tcG9zZS0kKHVuYW1lIC1zKS0kKHVuYW1lIC1tKSIgLW8gL3Vzci9sb2NhbC9iaW4vZG9ja2VyLWNvbXBvc2UKCmNobW9kICt4IC91c3IvbG9jYWwvYmluL2RvY2tlci1jb21wb3NlCgojIE9wdGlvbmFsOiBBZGQgJ3VidW50dScgdXNlciB0byBkb2NrZXIgZ3JvdXAKdXNlcm1vZCAtYUcgZG9ja2VyIHVidW50dQo="

  tags = {
    Name        = "my-ec2-tf"
    Terraform   = "true"
    Environment = "dev"
  }
}