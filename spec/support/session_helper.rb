module SessionHelper
  def retrieve_access_token
    post api_v1_session_path({email: 'test@example.com', password: 'poor_password'})

    expect(response.response_code).to eq 201
    expect(response.body).to match(/"access_token":".{20}"/)
    parsed = JSON(response.body)
    token = parsed['access_token']['access_token']

    @request.headers['HTTP_ACCESS_TOKEN'] = token
    @request.headers['ACCESS_TOKEN'] = token
    @request.headers['access_token'] = token
    @request.headers['http_access_token'] = token

    request.headers['HTTP_ACCESS_TOKEN'] = token
    request.headers['ACCESS_TOKEN'] = token
    request.headers['access_token'] = token
    request.headers['http_access_token'] = token

    request.headers[:http_access_token] = token
    request.headers[:access_token] = token
    request.headers[:ACCESS_TOKEN] = token
    request.headers[:HTTP_ACCESS_TOKEN] = token

    @request.headers[:http_access_token] = token
    @request.headers[:access_token] = token
    @request.headers[:ACCESS_TOKEN] = token
    @request.headers[:HTTP_ACCESS_TOKEN] = token
  end
end
