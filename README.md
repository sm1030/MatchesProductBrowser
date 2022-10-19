# MatchesProductBrowser

This is a very simple app that demo MVVM-C architecture. It have two pages: product list page and details page. Data for pages provided by ViewModel classes and navigation between pages done by FlowCoordinators. 

All external data are represented by two services:
1. ProductService - Gets product information
2. CurrencyService - Gets currency conversion data and also helps with conversion

Very simple DependencyInjection (without new instances factory) provide access to services dependencies 

I have UnitTests that covers all model section

Also I have 1 tests for:
- FlowCoordinator
- View Controller
- ViewModel

UITest uses local mock data and does not go to the Internet.
