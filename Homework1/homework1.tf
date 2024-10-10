# Variables for users
variable "username" {
  type = list(string)
  default = ["jenny","rose","lisa","jisoo","jihyo","sana","momo","dahyun"]
}

variable "add_to_blackpink" {
    type = list(string)
    default = ["jenny","rose","lisa","jisoo","miyeon"]
}

variable "add_to_twice" {
    type = list(string)
    default = ["jihyo","sana","momo","dahyun","mina"]
}

# Create users 
resource "aws_iam_user" "users" {
  count = "${length(var.username)}"
  name = "${element(var.username,count.index )}"
}

# Create groups
resource "aws_iam_group" "blackpink" {
    name = "blackpink"
}
resource "aws_iam_group" "twice" {
    name = "twice"
}

# Add users to groups
resource "aws_iam_user_group_membership" "add_users_to_group_blackpink" {
    for_each = { for user in var.add_to_blackpink : user => user }
    user = each.key
    groups = [aws_iam_group.blackpink.name]
}
resource "aws_iam_user_group_membership" "add_users_to_group_twice" {
    for_each = { for user in var.add_to_twice : user => user }
    user = each.key
    groups = [aws_iam_group.twice.name]
}

# To import users from aws
resource "aws_iam_user" "user1" {
    name = "miyeon"
}
resource "aws_iam_user" "user2" {
    name = "mina"
}