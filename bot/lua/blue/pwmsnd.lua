function tone( pin, freq, duty)
    pwm.stop(pin)
    pwm.setup(pin, freq, duty or 100)
    -- pwm.clock(pin, freq)
    pwm.start(pin)
end

function stoptone( pin )
    pwm.stop(pin)
end
