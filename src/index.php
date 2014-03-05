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

    <? foreach (glob("templates/*.hbs") as $filename) {
        include $filename;
    } ?>

    <script type="text/x-handlebars" data-template-name="new">
        <div class="row">
            <div class="col-sm-12">
                <section>
                    <h1>Modern Command</h1>
                </section>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-5">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            Get the Cost Per Hour
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div class="col-sm-12">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label  class="control-label">Lives</label>
                                    {{input value=lives class="form-control" placeholder="10"}}
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Play Time Per Life (mins)</label>
                                    {{input value=playTime class="form-control" placeholder="2"}}
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Life Recharge Time (mins)</label>
                                    {{input value=rechargeTime class="form-control" placeholder="10"}}
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Estimated hours of play without waiting</label>
                                    {{input value=playtime class="form-control" placeholder="8"}}
                                </div>
                            </form>
                        </div>

                        <button {{action 'addLifePack'}} type="button" class="btn btn-default">Add A Recharge Pack</button>
                    </div>
                </div>
            </div>
            <div class="col-sm-5 col-sm-offset-1">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            Get The Completion and Premium Content Costs
                        </h3>
                    </div>
                    <div class="panel-body">
                        <div class="col-sm-12">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-default">$ (USD)</button>
                                        <button type="button" class="btn btn-default active">&sect; (Special Currency)</button>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Average research/speedup cost</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">&sect;</span>
                                        {{input value=researchCost class="form-control" placeholder="7"}}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Estimated number of times needed to complete the game <br>(use 9999 for infinity)</label>
                                    {{input value=researchAmount class="form-control" placeholder="42"}}
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Total Premium Content Cost <br>(you may need a calculator)</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">&sect;</span>
                                        {{input value=premiumCost class="form-control" placeholder="1450"}}
                                    </div>
                                </div>
                            </form>
                        </div>

                        <button {{action 'addCreditPack'}} type="button" class="btn btn-default">Add a Credit Pack</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-6">
                <h2>Subscriptions</h2>
                <button {{action 'addSubscriptionPack'}} type="button" class="btn btn-default">Add Subscription</button>
            </div>
            <div class="col-sm-6">
                <h2>Caclulated results</h2>
                <ul class="media-list">
                    <li class="media">
                        <div class="media-body">
                            <h4 class="media-heading">
                                Upfront Cost <span class="badge">FREE</span>
                            </h4>
                            <p class="text-info">The Cost just to install the app.</p>
                        </div>
                    </li>
                    <li class="media">
                        <div class="media-body">
                            <h4 class="media-heading">
                                Per Hour Cost <span class="badge">$2.34</span>
                            </h4>
                            <p class="text-info"><code>Per Hour Cost</code> is the estimated cost to play continuously for one hour, ie, recharging lives or supplies</p>
                        </div>
                    </li>
                    <li class="media">
                        <div class="media-body">
                            <h4 class="media-heading">
                                To Complete <span class="badge">$39.00</span>
                            </h4>
                            <p class="text-info"><code>To Complete</code> is the minimum amount of in app purchases you need to play through the game without waiting. It includes skipping the waiting period imposed on things like research or building things This does not include the per hour cost of actually playing the game.</p>
                        </div>
                    </li>
                    <li class="media">
                        <div class="media-body">
                            <h4 class="media-heading">
                                Unlock All <span class="badge">$231.37</span>
                            </h4>
                            <p class="text-info"><code>Unlock All</code> is the total cost of premium content in the game that you cannot earn, and does not include completion costs.</p>
                        </div>
                    </li>
                    <li class="media">
                        <div class="media-body">
                            <h4 class="media-heading">
                                Subscription costs <span class="badge">$80.71</span>
                            </h4>
                            <p class="text-info"><code>Subscriptions</code> may not be required, but may change other costs that are not reflected here.</p>
                        </div>
                    </li>
                    <li class="media">
                        <div class="media-body">
                            <h4 class="media-heading">
                                Total Game Cost <span class="badge">$289.09</span>
                            </h4>
                            <p class="text-info"><code>Total Game Cost</code> is calculated by multiplying the estimated total game time by the cost per hour plus the completion cost plus the cost of the premium content</p>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
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
    <script src="js/app/newApp.js"></script>
    <script src="js/data/user.js"></script>
    <script src="js/data/app.js"></script>
    <script src="js/data/Fixtures.js"></script>
    </body>
</html>