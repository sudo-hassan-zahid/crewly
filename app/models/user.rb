class User < ApplicationRecord
  # Devise authentication modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { employee: 0, manager: 1, hr_manager: 2, admin: 3 }
  enum employment_status: { active: 0, on_leave: 1, terminated: 2 }

  belongs_to :department, optional: true
  belongs_to :designation, optional: true
  belongs_to :shift, optional: true
  belongs_to :manager, class_name: "User", optional: true

  has_many :subordinates, class_name: "User", foreign_key: "manager_id", dependent: :nullify
  has_many :attendance_records, dependent: :destroy
  has_many :leave_requests, dependent: :destroy
  has_one :salary_structure, dependent: :destroy
  has_many :payslips, dependent: :destroy
  has_many :performance_goals, dependent: :destroy
  has_many :performance_reviews, dependent: :destroy
  has_many :conducted_reviews, class_name: "PerformanceReview", foreign_key: "reviewer_id", dependent: :nullify
  has_many :employee_documents, dependent: :destroy
  has_many :activity_logs, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :employee_number, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def admin_or_hr?
    admin? || hr_manager?
  end
end
