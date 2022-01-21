data "aws_route53_zone" "this" {
  name         = "${var.domain_name}."
  private_zone = false
}

resource "aws_route53_record" "ingress" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "www.${data.aws_route53_zone.this.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.load_balancer.public_ip]
}

resource "aws_route53_record" "kube_api" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "kube.${data.aws_route53_zone.this.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.load_balancer.public_ip]
}