class Project < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: {maximum: 30 }
  validates :name, format: {with: /[A-Za-z0-9_ ]*/}

  has_many :entries
  def self.iron_find(id)
    self.where(id: id).first
  end

  def iron_print
    "Project: #{name} - "
  end

  def self.clean_old
    date = Time.now.midnight - 1.week
    projects = where("created_at < ?", date)
    projects.destroy_all
    
  end

  def self.last_created_projects(number)
    limit(number).order(created_at: :desc)
  end
  def total_hours_in_month(month, year)
      date = Time.parse("#{year}-#{month}-01")
      my_range = (date .. date.end_of_month)
      filtered_entries = entries.where(date: my_range)
      filtered_entries.reduce(0){|sum, entry| sum+(entry.hours.to_f+(entry.minutes.to_f/60))}
  end

end
