{self, ...}: {
  system = {
    configurationRevision = self.shortRev or self.dirtyShortRev or "dirty";
  };
}
