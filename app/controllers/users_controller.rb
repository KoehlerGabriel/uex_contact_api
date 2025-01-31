class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: current_user.slice(:name, :email, :created_at)
  end

  def update
    debugger
    if current_user.valid_password?(params[:current_password])
      if current_user.update(user_params)
        render json: { message: 'Usuário atualizado com sucesso.', user: current_user }, status: :ok
      else
        render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Senha atual incorreta. A atualização foi recusada.' }, status: :unauthorized
    end
  end

  def destroy
    if current_user.valid_password?(params[:password])
      current_user.destroy
      render json: { message: 'Conta excluída com sucesso.' }, status: :ok
    else
      render json: { error: 'Senha incorreta. A exclusão da conta foi recusada.' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
