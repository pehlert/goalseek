require "spec_helper"

RSpec.describe GoalSeek do
  it "raises for function that never crosses the goal within the given bound" do
    goalseek = GoalSeek::GoalSeek.new(Proc.new { |x|
      x*x
    })

    expect { goalseek.seek(-1) }.to raise_error(GoalSeek::InvalidBoundError)
  end

  it "finds exact goal for quadratic function" do
    goalseek = GoalSeek::GoalSeek.new(Proc.new { |x|
      x*x
    })

    expect(goalseek.seek(4)).to eq 2
  end

  it "finds exact goal for qubic function" do
    goalseek = GoalSeek::GoalSeek.new(Proc.new { |x|
      x*x*x
    })

    expect(goalseek.seek(27)).to eq 3.0
    expect(goalseek.seek(-1)).to eq -1.0
  end

  it "finds approximate goal for qubic function" do
    goalseek = GoalSeek::GoalSeek.new(Proc.new { |x|
      x*x*x
    })

    expect(goalseek.seek(10)).to eq 2.1544346900318834
  end
end
