class ReportsController < ApplicationController

  def financial_by_project
    @project = Project.find(params[:project_id])

    unless can?(:manage_backers, @project)
      redirect_to login_path
      return
    end

    @csv = Reports::Financial::Backers.report(params[:project_id])
    send_data @csv,
              :type => 'text/csv; charset=utf-8; header=present',
              :disposition => "attachment; filename=financial_report_of_project_#{params[:project_id]}.csv"
  end

  def attendance_by_project
    @project = Project.find(params[:project_id])

    unless can?(:manage_backers, @project)
      redirect_to login_path
      return
    end

    @csv = Reports::Users::Attendance.report(params[:project_id])
    send_data @csv,
              :type => 'text/csv; charset=utf-8; header=present',
              :disposition => "attachment; filename=attendance_report_of_project_#{params[:project_id]}.csv"
  end

  def projects_monthly
    return unless require_admin

    @csv = Reports::Financial::Monthly.report(params[:month], params[:year])
    send_data @csv,
              :type => 'text/csv; charset=utf-8; header=present',
              :disposition => "attachment; filename=monthly_report_#{"%02d" % params[:month]}_#{params[:year]}.csv"
  end

  def location_by_project
    return unless require_admin
    @csv = Reports::Location::Backers.report(params[:project_id])
    send_data @csv,
              :type => 'text/csv; charset=utf-8; header=present',
              :disposition => "attachment; filename=location_report_of_project_#{params[:project_id]}.csv"
  end

  def users_most_backed
    return unless require_admin
    @csv = Reports::Users::Backers.most_backed
    send_data @csv,
              :type => 'text/csv; charset=utf-8; header=present',
              :disposition => "attachment; filename=user_most_backed_#{params[:project_id]}.csv"
  end

  def all_confirmed_backers
    return unless require_admin
    @csv = Reports::Users::Backers.all_confirmed_backers
    send_data @csv,
              :type => 'text/csv; charset=utf-8; header=present',
              :disposition => "attachment; filename=all_confirmed_backers.csv"
  end

  def all_projects_owner
    return unless require_admin
    @csv = Reports::Users::Projects.all_project_owners
    send_data @csv,
              :type => 'text/csv; charset=utf-8; header=present',
              :disposition => "attachment; filename=all_projects_owner.csv"
  end

  def all_emails_to_newsletter
    return unless require_admin
    @csv = Reports::Users::Emails.all_emails
    send_data @csv,
      :type => 'text/csv; charset=utf-8; header=present',
      :disposition => "attachment; filename=all_emails.csv"
  end
end
