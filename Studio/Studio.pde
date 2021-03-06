/** 
 * By using LX Studio, you agree to the terms of the LX Studio Software
 * License and Distribution Agreement, available at: http://lx.studio/license
 *
 * Please note that the LX license is not open-source. The license
 * allows for free, non-commercial use.
 *
 * HERON ARTS MAKES NO WARRANTY, EXPRESS, IMPLIED, STATUTORY, OR
 * OTHERWISE, AND SPECIFICALLY DISCLAIMS ANY WARRANTY OF
 * MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR A PARTICULAR
 * PURPOSE, WITH RESPECT TO THE SOFTWARE.
 */

// ---------------------------------------------------------------------------
//
// Welcome to LX Studio! Getting started is easy...
// 
// (1) Quickly scan this file
// (2) Look at "Model" to define your model
// (3) Move on to "Patterns" to write your animations
// 
// ---------------------------------------------------------------------------


// Reference to top-level LX instance
import java.util.List;
heronarts.lx.studio.LXStudio lx;

void setup() {
  // Processing setup, constructs the window and the LX instance
  size(800, 720, P3D);  
  stratovo.model.VehicleSideFactory.basePath = sketchPath("../");
  lx = new heronarts.lx.studio.LXStudio(this, stratovo.model.VehicleFactory.getVehicle());
  lx.ui.setResizable(RESIZABLE);
}

void initialize(final heronarts.lx.studio.LXStudio lx, heronarts.lx.studio.LXStudio.UI ui) {
  // Add custom components or output drivers here
  //final String ARTNET_IP = "192.168.1.151";
  final String ARTNET_IP = "192.168.0.50";
  //lx.registerPattern(stratovo.patterns.LavaTest.class);
  List patterns = lx.getRegisteredPatterns();
  for (Object p : patterns) {
   // System.out.println(p);
  }
  
      lx.addProjectListener(new stratovo.ProjectListener(lx));
  

  try {
    // Construct a new DatagramOutput object
    LXDatagramOutput output = new LXDatagramOutput(lx);

    StreamingACNDatagram sacn = new StreamingACNDatagram(lx.getModel());
      sacn.setAddress(ARTNET_IP);
    output.addDatagram(sacn);

    // Add the datagram output to the LX engine
    
    //lx.addOutput(output);
    //lx.addOutput(new OPCOutput(lx, "localhost", 7890));
  } catch (Exception x) {
    x.printStackTrace();
  }
}

void onUIReady(heronarts.lx.studio.LXStudio lx, heronarts.lx.studio.LXStudio.UI ui) {
  // Add custom UI components here
  List<LXChannelBus> channels = lx.engine.getChannels();
  for (LXChannelBus c : channels) {
    //System.out.println(c.label.getStrin  g());
    Vehicle v = (Vehicle) lx.getModel();
    LXModel m = new LXModel(v.lava);
    //c.setModel(m);
  }
}

void draw() {
  // All is handled by LX Studio
}

// Configuration flags
final static boolean MULTITHREADED = true;
final static boolean RESIZABLE = true;

// Helpful global constants
final static float INCHES = 1;
final static float IN = INCHES;
final static float FEET = 12 * INCHES;
final static float FT = FEET;
final static float CM = IN / 2.54;
final static float MM = CM * .1;
final static float M = CM * 100;
final static float METER = M;
