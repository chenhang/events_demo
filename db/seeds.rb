# This insert demo data to database

team = Team.create(name: "test")

admin_account = Account.create(name: "admin")
account_a = Account.create(name: "a")
account_b = Account.create(name: "b")

admin_user = admin_account.users.create(name: admin_account.name, team_id: team.id)
user_a = account_a.users.create(name: account_a.name, team_id: team.id)
user_b = account_b.users.create(name: account_b.name, team_id: team.id)

project_a = Project.create(name: "project_a", team_id: team.id)
project_b = Project.create(name: "project_b", team_id: team.id)

Access.create(project_id: project_a.id, user_id: user_a.id)
Access.create(project_id: project_a.id, user_id: user_b.id)
Access.create(project_id: project_b.id, user_id: user_b.id)
Access.create(project_id: project_a.id, user_id: admin_user.id)
Access.create(project_id: project_b.id, user_id: admin_user.id)
Access.create(project_id: project_b.id, user_id: user_a.id)

50.times do |i|
  project_id = i.modulo(2)+1
  todo = Todo.create(title: "test_#{i}", content: "test_content_#{i}",
                     creator_id: admin_user.id, project_id: project_id)
  todo.handler = admin_user
  todo.update(doer: user_a)
  todo.update(due: Time.now)
  todo.handler = user_a
  todo.update(doer: user_b)
  todo.handler = user_b
  todo.finish()
  todo.handler = admin_user
  todo.delete()
  comment = Comment.create(creator: admin_user, content: "test_comment",
                           commentable: todo)
end