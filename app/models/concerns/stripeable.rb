module Stripeable
  def subscribe(source)
    set_stripe_customer(source)
    create_subscription
    self.subscribed = true
    self.save
  end

  private

  def set_stripe_customer(source)
    return if stripe_id
    self.stripe_id = Stripe::Customer.create({
      email: email,
      source: source
    }).id
  end

  def create_subscription
    return if subscribed?
    sub = Stripe::Subscription.create({
      customer: stripe_id,
      items: [{plan: ENV["THREAD_BOX_PLAN_ID"]}]
    })
    set_current_period_end(sub.current_period_end)
  end

  def set_current_period_end(timestamp)
    self.current_period_end = DateTime.strptime(timestamp.to_s, "%s")
  end
end
