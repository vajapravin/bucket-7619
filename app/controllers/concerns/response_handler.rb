module ResponseHandler
  def success(contents)
    render json: ApiResponse.good(contents), status: :ok
  end

  def bad_request(contents)
    render json: ApiResponse.bad(contents), status: :bad_request
  end
end