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
                        <li class="active">{{#link-to 'index'}}Home{{/link-to}}</li>
                        <li><a href="#about">About</a></li>
                        <li><a href="#contact">Contact</a></li>
                    </ul>
                    <ul class="nav navbar-nav pull-right">
                        <li>{{#link-to 'newapp'}}<span class="glyphicon glyphicon-plus"></span> Add App{{/link-to}}</li>
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
            <li>
                {{displayName}} for {{platform.displayName}} in category: {{category.displayName}}
                <ul>
                    <li>PerHour: {{money perHour}}</li>
                    <li>toComplete: {{money toComplete}}</li>
                    <li>Unlock All: {{money unlockAll}}</li>
                    <li>Subscription: {{money subscription}}</li>
                </ul>
            </li>
            {{/each}}
        </ul>
    </script>

    <script type="text/x-handlebars" data-template-name="newapp">
        <div id="root" style="width: 400px; margin: 40px auto; padding: 10px; border-style: dashed; border-width: 1px;">
            Please Wait, loading login widget
        </div>

        {{login}}

    </script>

    <script src="js/libs/components/jquery/jquery.js"></script>
    <script src="js/libs/accounting.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/libs/components/handlebars/handlebars.js"></script>
    <script src="js/libs/components/ember/ember.js"></script>
    <script src="js/libs/components/ember-data/ember-data.js"></script>
    <script src="js/helpers/helpers.js"></script>
    <script src="js/app/app.js"></script>
    <script src="js/app/Router.js"></script>
    <script src="js/app/index.js"></script>
    <script src="js/data/user.js"></script>
    <script src="js/data/app.js"></script>
    <script src="js/data/Fixtures.js"></script>

    <script src="https://cdn.auth0.com/w2/auth0-widget-2.5.13.min.js"></script>
    </body>
</html>