# This insert demo data to database

team = Team.create(name: "test")

admin_user = User.create(name: "admin_user", team_id: team.id)
user_a = User.create(name: "user_a", team_id: team.id)
user_b = User.create(name: "user_b", team_id: team.id)
project_a = Project.create(name: "project_a", team_id: team.id)
project_b = Project.create(name: "project_b", team_id: team.id)
Access.create(project_id: project_a.id, user_id: user_a.id)
Access.create(project_id: project_a.id, user_id: user_b.id)
Access.create(project_id: project_b.id, user_id: user_b.id)
Access.create(project_id: project_a.id, user_id: admin_user.id)
Access.create(project_id: project_b.id, user_id: admin_user.id)

50.times do |i|
  todo = Todo.create(title: "test_#{i}", content: "test_content_#{i}",
                     creator_id: admin_user.id, project_id: project_b.id)
  todo.assign(admin_user, user_a)
  todo.change_due(user_a, todo.created_at)
  todo.assign(user_a, user_b)
  todo.finish(user_b)
  todo.delete(user_a)
end