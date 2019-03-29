it('loads page', () => {
  cy.visit('/')
  cy.contains('It works! This is the default homepage for this Open edX instance.')
})
