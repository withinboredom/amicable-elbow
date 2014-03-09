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
        <link rel="stylesheet" href="css/bootstrap-switch.css">

        <script type="text/javascript">
            <!--
            (function() {
                if ("-ms-user-select" in document.documentElement.style && navigator.userAgent.match(/IEMobile\/10\.0/)) {
                    var msViewportStyle = document.createElement("style");
                    msViewportStyle.appendChild(
                        document.createTextNode("@-ms-viewport{width:auto!important}")
                    );
                    document.getElementsByTagName("head")[0].appendChild(msViewportStyle);
                }
            })();
            //-->
        </script>

        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>

    <? foreach (glob("templates/*.hbs") as $filename) {
        include $filename;
    } ?>

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
    <script src="js/libs/bootstrap-switch.js"></script>
    <script src="js/libs/components/handlebars/handlebars.js"></script>
    <script src="js/libs/components/ember/ember.js"></script>
    <script src="js/libs/ember-states.js"></script>
    <script src="js/libs/components/ember-data/ember-data.js"></script>
    <script src="js/helpers/helpers.js"></script>
    <script src="js/app/app.js"></script>
    <script src="js/app/Router.js"></script>
    <script src="js/app/index.js"></script>
    <script src="js/app/newApp.js"></script>
    <script src="js/data/user.js"></script>
    <script src="js/data/app.js"></script>
    <script src="js/data/Fixtures.js"></script>
    </body>
</html>