import React from "react";
import DocViewer from "react-doc-viewer";

const VideoRenderer = ({
  mainState: { currentDocument },
}) => {
  if (!currentDocument) return null;

  return (
    <div className="video-renderer" >
      <video controls>
        <source src={currentDocument.fileData}/>
      </video>
    </div>
  );
};

VideoRenderer.fileTypes = ["mp4", "video/mp4"];
VideoRenderer.weight = 1;

export default VideoRenderer;
