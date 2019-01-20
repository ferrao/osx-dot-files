command: """
    network-throughput.widget/lib/network.sh
"""
refreshFrequency: 2000

style: """
    // Change bar height
    bar-height = 3px

    // Align contents left or right
    widget-align = left

    // Position this where you want
    top 6px
    left 58px

    // Statistics text settings
    color #fff
    font-family scientifica, SF Mono, Menlo;
    background #dde2e3
    padding 2px 5px 7px
    border-radius 3px

    .container
        width: 200px
        text-align: widget-align
        position: relative
        clear: both

    .stats-container
        width: 100%
        border-collapse collapse

    td
        font-size: 9px
        font-weight: 600
        color #668099
        text-align: widget-align

    .stat
        width: 50%
        down, .label-down
            float: left
            text-align left
        .up, .label-up
            float: right
            text-align right

    .bar-container
        width: 100%
        height: bar-height
        border-radius: bar-height
        clear: both
        position: absolute

    .bar
        height: bar-height
        transition: width .2s ease-in-out

    .bar:first-child
        border-radius: bar-height 0 0 bar-height
        float: left

    .bar:last-child
        border-radius: 0 bar-height bar-height 0
        float: right

    .bar-down
        background: rgba(#c00, .8)

    .bar-up
        background: rgba(#0bf, .8)
"""

render: -> """
    <div class="container">
        <table class="stats-container">
            <tr>
                <td class="stat"><span class="label-down">↓&nbsp;</span><span class="down"></span></td>
                <td class="stat"><span class="label-up">&nbsp;↑</span><span class="up"></span></td>
            </tr>
        </table>
        <div class="bar-container">
            <div class="bar bar-down"></div>
            <div class="bar bar-up"></div>
        </div>
    </div>
"""

update: (output, domEl) ->

    usage = (bytes) ->
        kbits = bytes * 8 / 1024
        usageFormat kbits

    usageFormat = (kbits) ->
        if kbits > 1024
            mbits = kbits / 1024
            "#{parseFloat(mbits.toFixed(1))} Mb/s"
        else
            "#{parseFloat(kbits.toFixed(2))} Kb/s"

    updateStat = (sel, currBytes, totalBytes) ->
        percent = (currBytes / totalBytes * 100).toFixed(1) + "%"
        $(domEl).find(".#{sel}").text usage(currBytes)
        $(domEl).find(".bar-#{sel}").css "width", percent

    args = output.split "^"

    downBytes = (Number) args[0]
    upBytes = (Number) args[1]

    totalBytes = downBytes + upBytes

    updateStat 'down', downBytes, totalBytes
    updateStat 'up', upBytes, totalBytes
