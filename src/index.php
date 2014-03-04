<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Appti2ude -- The Real Cost of Apps</title>
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-theme.css">
        <link rel="stylesheet" href="css/style.css">

        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>

    <script type="text/x-handlebars">
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    {{#link-to 'index' classNames='navbar-brand' }}Appti2ude{{/link-to}}
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        {{#link-to "index" activeClass="active" tagName="li"}}{{#link-to 'index'}}All{{/link-to}}{{/link-to}}
                        <li><a href="#about">About</a></li>
                        <li><a href="#contact">Contact</a></li>
                    </ul>
                    <ul class="nav navbar-nav pull-right">
                        {{#unless isAuthenticated}}
                            <li><a {{action login "facebook"}} href="#"><span class="glyphicon glyphicon-plus"></span> Add App</a></li>
                        {{else}}
                            {{#link-to "app.new" activeClass="active" tagName="li"}}{{#link-to 'app.new'}}<span class="glyphicon glyphicon-plus"></span> Add App{{/link-to}}{{/link-to}}
                            <li class="dropdown"><a class="brand dropdown-toggle" data-toggle="dropdown" ><img {{bind-attr src="picture"}} style="height:25px" /> {{nick}} <b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a {{action logout}} href="#">Logout</a></li>
                                </ul>
                            </li>
                        {{/unless}}
                    </ul>
                </div><!--/.nav-collapse -->
            </div>
        </div>

        <div class="container">
            {{outlet}}
        </div><!-- /.container -->
    </script>

    <script type="text/x-handlebars" data-template-name="index">
        <h1>Top 50 Free Apps</h1>

        <ul>
            {{#each}}
            <li class="app">
                {{displayName}} for {{platform.displayName}} in category: {{category.displayName}}
                <ul class="stats">
                    <li>PerHour: {{money perHour}}</li>
                    <li>toComplete: {{money toComplete}}</li>
                    <li>Unlock All: {{money unlockAll}}</li>
                    <li>Subscription: {{money subscription}}</li>
                </ul>
                <ul class="comments">
                </ul>
            </li>
            {{/each}}
        </ul>
    </script>

    <script type="text/x-handlebars" data-template-name="app/new">
<h1>TEST</h1>
    </script>

    <script src="http://ajax.aspnetcdn.com/ajax/mobileservices/MobileServices.Web-1.1.3.min.js"></script>
    <script src="https://cdn.auth0.com/w2/auth0-widget-2.5.13.min.js"></script>

    <script>
        var client = new WindowsAzure.MobileServiceClient(
            "https://appti2ude.azure-mobile.net/",
            "kiyLJPbCirhUHJXPjZDznVfiIzaFkr54"
        );
    </script>

    <script src="js/libs/components/jquery/jquery.js"></script>
    <script src="js/libs/components/jquery.cookie.js"></script>
    <script src="js/libs/accounting.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/libs/components/handlebars/handlebars.js"></script>
    <script src="js/libs/components/ember/ember.js"></script>
    <script src="js/libs/ember-states.js"></script>
    <script src="js/libs/components/ember-data/ember-data.js"></script>
    <script src="js/helpers/helpers.js"></script>
    <script src="js/app/app.js"></script>
    <script src="js/app/Router.js"></script>
    <script src="js/app/index.js"></script>
    <script src="js/data/user.js"></script>
    <script src="js/data/app.js"></script>
    <script src="js/data/Fixtures.js"></script>
    </body>
</html>