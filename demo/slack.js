/**
 * Returns a key/value object containing all variables relevant for the activity.
 *
 * That includes project level variables, plus any variables visible for
 * the relevant environment for the activity, if any.
 *
 * Note that JSON-encoded values will show up as a string, and need to be
 * decoded with JSON.parse().
 */
function variables() {
    var vars = {};
    activity.payload.deployment.variables.forEach(function(variable) {
        vars[variable.name] = variable.value;
    });
    return vars;
}

/**
 * Sends a color-coded formatted message to Slack.
 *
 * You must first configure a Platform.sh variable named "SLACK_URL".
 * That is the group and channel to which the message will be sent.
 *
 * To control what events it will run on, use the --events switch in
 * the Platform.sh CLI.
 *
 * @param {string} title
 *   The title of the message block to send.
 * @param {string} message
 *   The message body to send.
 */
function sendSlackMessage(title, message) {
    var body = {
        'attachments': [{
            'title': title,
            'text': message,
            'color': 'good',
        }],
    };
    var url = variables()['SLACK_URL'];
    if (!url) {
        throw new Error('You must define a SLACK_URL project variable.');
    }
    var resp = fetch(url,{
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(body),
    });
    if (!resp.ok) {
        console.log('[LOG] Sending slack message failed: ' + resp.body.text());
    }
}

/**
 * Extract the JSON output of 'composer outdated' as a nice formatted text.
 *
 * @param {json} npmDiff
 *   The output of 'composer outdated --format json' command
 */
function extractDiff(npmDiff) {
    // console.log(JSON.stringify(npmDiff, null, 2));
    // console.log(npmDiff)
    Object.keys(npmDiff).forEach(function(key) {
        var val = o[key];
        console.log(key)
      });
    var result = npmDiff.map(function(i) { 
        console.log(i)
        if (i['current'] == i['wanted']) return '';
        return '- Updated ' + i + ' (' + i.current+ ' => ' + i.wanted + '): ' + i['latest'] + '\n';
    });
    return result.join('');
}

// @TODO: load it properly via a forEach() function. Currently it's hardcoded with the app name.
console.log(JSON.stringify(activity, null, 2));

var npmDiff = activity.payload.deployment.webapps.app.variables.env['NPM_DIFF'];
var message = extractDiff(npmDiff);
var title = 'NPM packages have been updated on the environment: "' + activity.payload.environment.name + '" (' + activity.payload.environment.project + ')';
sendSlackMessage(title, message);