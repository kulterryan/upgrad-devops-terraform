# Create ALB
resource "aws_alb" "alb" {  
  name            = "${local.name}-alb"
  subnets         = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
        ]
  security_groups = [module.sgpublic.security_group_id]
  internal  = false
  tags = local.common_tags
}

# Create ALB listener
resource "aws_alb_listener" "alb-listener" {  
  load_balancer_arn = "${aws_alb.alb.arn}"  
  port              = "80"  
  protocol          = "HTTP"
  
  default_action {    
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
  }
 }
}

# Create listener rule to forward /jenkins towards Jenkins EC2 instance
resource "aws_alb_listener_rule" "listener-rule-jenkins" {
  depends_on   = [aws_alb_target_group.jenkins-tg]  
  listener_arn = "${aws_alb_listener.alb-listener.arn}"  
  action {    
    type             = "forward"    
    target_group_arn = "${aws_alb_target_group.jenkins-tg.id}"  
  }   
  condition {
    path_pattern {
      values = ["/jenkins/*","/jenkins"]
    }
  }
}

# Create listener rule to forward /app towards APP EC2 instance
resource "aws_alb_listener_rule" "listener_rule_app" {
  depends_on   = [aws_alb_target_group.app-tg]  
  listener_arn = "${aws_alb_listener.alb-listener.arn}"  
  action {    
    type             = "forward"    
    target_group_arn = "${aws_alb_target_group.app-tg.id}"  
  }   
  condition {
    path_pattern {
      values = ["/app/*", "/app"]
    }
  }
}

# Create Jenkins Target group for EC2 Jenkins instance
resource "aws_alb_target_group" "jenkins-tg" {  
  name     = "jenking-tg"  
  port     = "8080"  
  protocol = "HTTP"  
  vpc_id   = module.vpc.vpc_id  
  tags = local.common_tags
  health_check {
    path = "/jenkins"
    port = 8080
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200-499"  
  }
}

# Create App Target Group for EC2 App instance
resource "aws_alb_target_group" "app-tg" {  
  name     = "app-tg"  
  port     = "8080"
  protocol = "HTTP"  
  vpc_id   = module.vpc.vpc_id  
  tags  = local.common_tags
  health_check {
    path = "/app"
    port = 8080
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200-499"  
  }
}

# Attach Jenkins EC2 to Jenkins Target group
resource "aws_lb_target_group_attachment" "jenkins" {
  depends_on   = [aws_alb_target_group.jenkins-tg]  
  target_group_arn = "${aws_alb_target_group.jenkins-tg.arn}"
  target_id        = module.ec2_jenkins.id
  port             = "8080"
}

# Attach App EC2 to App Target group
resource "aws_lb_target_group_attachment" "app" {
  depends_on   = [aws_alb_target_group.app-tg]  
  target_group_arn = "${aws_alb_target_group.app-tg.arn}"
  target_id        = module.ec2_app.id
  port             = "8080"
}
