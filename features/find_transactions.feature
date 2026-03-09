# features/find_transactions.feature

Feature: Recherche de transactions dans ParaBank
  En tant qu'utilisateur connecté à ParaBank pour Find Transactions
  Je veux rechercher des transactions selon différents critères
  Afin de retrouver facilement mes opérations bancaires

  Background:
    Given l'utilisateur est connecté à ParaBank pour Find Transactions
    And l'utilisateur est sur la page "Find Transactions"

  Scenario: Recherche de transaction par ID
    When il recherche une transaction avec l'ID "12145"
    Then la liste des transactions correspondantes doit s'afficher

  Scenario: Recherche de transactions par date
    When il recherche des transactions avec la date "03-09-2026"
    Then la liste des transactions correspondantes doit s'afficher

  Scenario: Recherche de transactions par plage de dates
    When il recherche des transactions entre "01-01-2026" et "31-12-2024"
    Then Un message d'erreur doit s'afficher indiquant que la date de fin doit être supérieure à la date de début

  Scenario: Recherche de transactions par montant
    When il recherche des transactions avec le montant "100"
    Then la liste des transactions correspondantes doit s'afficher
