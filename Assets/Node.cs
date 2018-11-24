using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Node {

    public bool isWalkable;
    public Vector3 nodePosition;

    public Node(bool isWalkable, Vector3 nodePosition)
    {
        this.isWalkable = isWalkable;
        this.nodePosition = nodePosition;
    }
}
