# require 'render_anywhere'
# require 'csv'
#
# class DownloadsController < ApplicationController
#   include RenderAnywhere
#   respond_to :pdf
#
#   def show
#     respond_with do |format|
#       format.pdf { send_report_pdf }
#     end
#   end
#
#   private
#
#   def report_pdf
#     report = Ticket.closed_one_month
#     CSV.open('report.csv', 'wb') do |csv|
#       csv << report
#     end
#   end
#
#   def send_report_pdf
#     send_file(report_pdf.to_pdf,
#               filename: report_pdf.filename,
#               type: 'application/pdf',
#               disposition: 'inline')
#   end
# end