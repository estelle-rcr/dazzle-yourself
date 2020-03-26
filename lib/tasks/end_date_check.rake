desc "Change project.state to 'finished' if Time.now > end_date "
task end_date_check: :environment do
  Project.where(state: "published").each do |project|
    if project.end_date < Time.now
      project.update(state: "finished")
    end
  end
end