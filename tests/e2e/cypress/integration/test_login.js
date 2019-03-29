describe('Login tests', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it('allows admin user access', () => {
    cy.contains('Sign in').click();
    cy.get('#login-email').type('user@example.com');
    cy.get('#login-password').type('secret');
    cy.get('.action').click();
    cy.contains('Discover New').click();
    cy.contains('We couldn\'t find any results');
  })
})