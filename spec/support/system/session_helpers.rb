module SessionHelpers
  # Este método simula o login de um administrador pela interface.
  # Lembre-se de ajustar a URL, os nomes dos campos e o botão para
  # corresponderem à sua tela de login real.
  def login_as_admin(admin)
    visit '/login' 

    fill_in 'Email', with: admin.email      
    fill_in 'Senha', with: 'password'     

    click_button 'Entrar'                   

    # Verificação opcional, mas recomendada.
    expect(page).to have_content('Login realizado com sucesso')
  end
end