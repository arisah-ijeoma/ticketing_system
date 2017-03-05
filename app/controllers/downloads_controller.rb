class DownloadsController < ApplicationController

  def show
    respond_to do |format|
      format.pdf { send_report_pdf }
    end
  end

  private

  def report_pdf
    Ticket.closed_one_month
  end

  def send_report_pdf
    send_file(report_pdf.to_pdf,
              filename: report_pdf.filename,
              type: 'application/pdf',
              disposition: 'inline')
  end
end