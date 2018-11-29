using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Node {

    public bool isWalkable;
    public Vector3 nodePosition;
    public int gridX;
    public int gridY;
    
    public int gCost;
    public int hCost;
    public Node parent;

    public bool hasBeenChecked;

    public Node(bool isWalkable, Vector3 nodePosition, int gridX, int gridY)
    {
        this.isWalkable = isWalkable;
        this.nodePosition = nodePosition;
        this.gridX = gridX;
        this.gridY = gridY;
    }

    public int fCost
    {
        get { return gCost + hCost;  }
    }
}
