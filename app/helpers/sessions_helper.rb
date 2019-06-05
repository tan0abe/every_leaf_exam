module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?  # ユーザーがログインしていればtrue、その他ならfalseを返す
  end

  def authenticate_user
    if current_user == nil
      redirect_to new_session_path, notice: "ログインが必要です"
    end
  end

  def forbid_login_user
    if current_user
      redirect_to tasks_path, notice: "ログイン済です"
    end
  end

  def enssure_correct_user
    # if current_user.id != params[:id].to_i
    #   redirect_to tasks_path, notice: "権限がありません"
    # end

    if current_user.present? #ログインしていない時は、current_user.idを確かめないので、current_userがnilというエラーにならない
      unless current_user.id == params[:id].to_i  #idがstringで渡されているのでintegerに直す
        redirect_to tasks_path, notice: "他人のプロフィールは見ることができません！"
      end
    end
  end
end