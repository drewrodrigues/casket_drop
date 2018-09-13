Rails.configuration.stripe = {
  publishable_key: ENV["THREAD_BOX_STRIPE_PUB_KEY"],
  secret_key: ENV["THREAD_BOX_STRIPE_SECRET_KEY"],
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
