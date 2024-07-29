variable "list_of_open_ports" {
  description = "List of ports to open in the security group"
  type        = list(number)
  default     = [80, 22]
}