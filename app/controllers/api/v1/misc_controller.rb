class Api::V1::MiscController < API::V1::BaseController
  def statistics
    stats = []
    stats << { deposit: Deposit.sum(:amount) }
    stats << { withdraw: Withdraw.sum(:amount) }
    stats << { 'Gross Profit': { value: '$457', trending: '12%', trending_icon: 'os-icon-arrow-2-down' } }
    stats << { 'New Customers': { value: '125', trending: '12%', trending_icon: 'os-icon-graph-down' } }
    stats << { customers: [] }
    stats << { transactions: {
        total: 142,
        data: {
          labels: ["Red", "Blue", "Yellow", "Green", "Purple"],
          datasets: [{
            data: [300, 50, 100, 30, 70],
            backgroundColor: ["#5797fc", "#7e6fff", "#4ecc48", "#ffcc29", "#f37070"],
            hoverBackgroundColor: ["#5797fc", "#7e6fff", "#4ecc48", "#ffcc29", "#f37070"],
            borderWidth: 0
          }]
        },
      }
    }
    render json: { stats: stats }
  end

  def profile
    render json: current_user
  end

  def validate_token
    render json: { success: user_signed_in? }
  end

  def executives
    render json: current_user.children.includes(:uid).map { |e| {
      fullname: e.profile.fullname,
      identifier: e.identifier,
      executives_count: e.children.count,
      transactions: e.total_children_transactions,
      active: e.active,
      amount: e.sum_children_amount } }
  end
end