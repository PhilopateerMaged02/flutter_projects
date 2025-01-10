abstract class NewsAppStates {}
class NewsAppInitialState extends NewsAppStates{}
class NewsAppNavBarState extends NewsAppStates{}

class NewsGetBuisnessLoadingState extends NewsAppStates{}
class NewsGetBuisnessSuccessState extends NewsAppStates{}
class NewsGetBuisnessErrorState extends NewsAppStates{}

class NewsGetSportsLoadingState extends NewsAppStates{}
class NewsGetSportsSuccessState extends NewsAppStates{}
class NewsGetSportsErrorState extends NewsAppStates{}

class NewsGetScienceLoadingState extends NewsAppStates{}
class NewsGetScienceSuccessState extends NewsAppStates{}
class NewsGetScienceErrorState extends NewsAppStates{}

class NewsAppChangeModeState extends NewsAppStates{}

class NewsGetSearchLoadingState extends NewsAppStates{}
class NewsGetSearchSuccessState extends NewsAppStates{}
class NewsGetSearchErrorState extends NewsAppStates{}