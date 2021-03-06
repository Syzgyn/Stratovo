package stratovo.patterns;

import heronarts.lx.LX;
import heronarts.lx.LXPattern;
import heronarts.lx.modulator.SawLFO;
import heronarts.lx.parameter.BooleanParameter;
import heronarts.lx.parameter.CompoundParameter;
import heronarts.lx.parameter.LXParameter;

public abstract class SpinningPattern extends LXPattern {

	public static final float TWO_PI = (float) Math.PI * 2;

	public final CompoundParameter speed = (CompoundParameter)
			new CompoundParameter("Speed", 17000, 49000, 5000)
			.setExponent(2)
			.setDescription("Speed of lighthouse motion");

	public final BooleanParameter reverse =
			new BooleanParameter("Reverse", false)
			.setDescription("Reverse the direction of spinning");

	protected final SawLFO azimuth = (SawLFO) startModulator(new SawLFO(0, TWO_PI, speed));

	public SpinningPattern(LX lx) {
		super(lx);
		addParameter("speed", this.speed);
		addParameter("reverse", this.reverse);
	}

	public void onParameterChanged(LXParameter p) {
		if (p == this.reverse) {
			float start = this.reverse.isOn() ? TWO_PI : 0;
			float end = TWO_PI - start;
			double basis = this.azimuth.getBasis();
			this.azimuth.setRange(start, end).setBasis(1 - basis); 
		}
	}
}