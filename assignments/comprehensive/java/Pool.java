/**
 * @author Francisco Trindade
 * March 8 2018
 * CSI2120 - Assignment 4
 */

public class Pool {
    public double lat, lon, latRad, lonRad;
    public String name;
    public TreeNode<Pool> treeNode;

    // Constructor
    public Pool(double lat, double lon, String name) {
        this.lat = lat;
        this.lon = lon;
        this.name = name;
        this.latRad = (lat*Math.PI)/180.0;
        this.lonRad = (lon*Math.PI)/180.0;
    }

    /**
     * Gets the difference in distance between this pool and inputted pool
     * @param pool    Pool object to compare distance to
     * @return        The distance between input pool and this pool
     */
    public double getDist(Pool pool) {
        double latRad2 = pool.latRad;
        double lonRad2 = pool.lonRad;
        double latPart = Math.pow(Math.sin((this.latRad-latRad2)/2.0),2);
        double lonPart = Math.pow(Math.sin((this.lonRad-lonRad2)/2.0),2);
        double innerPart = latPart+(Math.cos(this.latRad)*Math.cos(latRad2)*lonPart);
        double dRads = 2.0*Math.asin(Math.sqrt(innerPart));
        double distance = 6371.0*dRads;
        return distance;
    }

    /**
     * Fancy print values in this class
     * @return    The fancily printed class in string
     */
    public String toString() {
        return "Name: "+this.name+" | Lat: "+this.lat+" | Lon: "+this.lon;
    }
}