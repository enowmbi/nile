class SendMailsWorker
  include Sidekiq::Worker

  def perform(*args)
    args.times do
      Rails.logger.debug('<<<<<SENDING  A AMAILL >>>>>>')
    end
  end
end
