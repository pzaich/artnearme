<%
  @path = "/etc/profile.d/rubber.sh"
  current_path = "/mnt/#{rubber_env.app_name}-#{Rubber.env}/current" 
%>

# convenience to simply running rails console, etc with correct env
export RUBBER_ENV=<%= Rubber.env %>
export RAILS_ENV=<%= Rubber.env %>
export AWS_ACCESS_KEY=<% ENV['AWS_ACCESS_KEY'] %>
export AWS_SECRET_KEY=<% ENV['AWS_SECRET_KEY'] %>
alias current="cd <%= current_path %>"
alias release="cd <%= Rubber.root %>"
