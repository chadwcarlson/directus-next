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

    console.log((new Date).getDay());

    if ((new Date).getDay() === 5) {
        message += "\r\nOn a Friday! :calendar:";
    }

    var color = activity.result === 'success'
        ? '#66c000'
        : '#ff0000';

    var body = {
        attachments: [{
            title: title,
            text: message,
            color: color,
        }],
    };

    var url = variables()['SLACK_URL'];

    if (!url) {
        throw new Error('You must define a SLACK_URL project variable.');
    }

    var resp = fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(body),
    });

    if (!resp.ok) {
        console.log("Sending slack message failed: " + resp.body.text());
    }
}

function variables() {
    var vars = {};
    activity.payload.deployment.variables.forEach(function(variable) {
        vars[variable.name] = variable.value;
    });

    return vars;
}

sendSlackMessage(activity.text, activity.log);