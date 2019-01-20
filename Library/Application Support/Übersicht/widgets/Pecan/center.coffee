command: "bash Pecan/scripts/system"

refreshFrequency: 2000

render: (output) ->
  "<div class='screen'><div class='holder'><div class='center'><img class='cpu' src='/images/cpu.png' />#{output}<img class='ram' src='/images/ram.png' /></div></div></div></div>"

